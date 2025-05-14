import numpy as np
from BitVector import *
from functions import *
from bin_math import *

aes_properties = {
    "Nr": {         # Number of internal rounds
        128: 10,
        192: 12,
        256: 14
    },
    "irred_poly": 0b100011011, # irredicible polynomial
}


class AES():

    def __init__(self, key_length=128):
        self.load_properties(key_length)
        self.generate_sbox()
        self.gfp2 = generate_gf(2)
        self.gfp3 = generate_gf(3)
        self.generate_rc(self.Nr)


    def load_properties(self, key_length):
        """
        Load properties of AES related to its key length
        """
        if key_length == 128:
            self.irred_poly = aes_properties["irred_poly"]  # Irreducible polynomial of AES
            self.Nr = aes_properties["Nr"][key_length]      # Number of internal rounds
            self.Nk = key_length // 32                      # Number of 32-bit words in key, e.g. [0x--, 0x--, 0x--, x---] for AES-128
            self.Nb = 4                                     # Number of columns in state matrix
        
        elif key_length in [192, 256]:
            raise Exception(f"AES-{key_length} is not implemented in the code, except for AES-128.")
        
        else:
            raise Exception("Please enter a valid key length: 128, 192, 256.")
        
    def generate_sbox(self):
        """
        Generate S-Box
        """
        irred_poly = BitVector(bitstring='100011011') # irreducible polynomial
        subBytesTable = [] 

        c = BitVector(bitstring='01100011')

        for i in range(0, 256):
            # Initialise bit 
            b = BitVector(intVal = i, size=8)

            # GF(2) Inverse
            b = b.gf_MI(irred_poly, 8) if i != 0 else BitVector(intVal=0)

            # Affine mapping
            b1,b2,b3,b4 = [b.deep_copy() for x in range(4)]
            b ^= (b1 >> 4) ^ (b2 >> 5) ^ (b3 >> 6) ^ (b4 >> 7) ^ c

            subBytesTable.append(int(b))
        
        self.sbox = subBytesTable

    def generate_rc(self, Nr=10):
        """
        Generate list of round coefficient (RC) for use in KeyExpansion
        """
        rc = [0x01]
        for _ in range(1, Nr):
            rc.append(gf_mult(rc[-1], 0x02))
        
        self.rc = rc

    def g(self, word, rc):
        """
        g() function in KeyExpansion
        """
        bytes = word_to_bytes(word)     # Convert word to list of 4 bytes

        # 1. RotWord: left-rotate by 1 byte
        bytes = bytes[1:] + bytes[:1]

        # 2. SubWord: substitute using S-box
        bytes = [self.sbox[byte] for byte in bytes]

        # 3. # XOR first byte with round constant
        bytes[0] ^= rc

        return bytes_to_word(bytes)     # Convert back to a 32-bit word

    def KeyExpansion(self, key, Nb=4, Nk=4, Nr=10):
        """
        Key Expansion
        """
        # Initialise first round of keys
        w = [0] * (Nb + Nk * Nr)
        for i in range(Nb):
            w[i] = bytes_to_word(key[i])

        # Calculate subsequent round of keys
        for i in range(1, Nr+1):
            for j in range(4):
                if j == 0:
                    w[4*i] = w[4*(i-1)] ^ self.g(w[4*i-1], rc=self.rc[i-1])
                else: 
                    w[4*i + j] = w[4*i + j - 1] ^ w[4*(i-1) + j]

        return w

    def enter_key(self, key):
        self.key = process_str(key)
        
        key = process_key(key, self.Nk)
        self.W = self.KeyExpansion(key, self.Nb, self.Nk, self.Nr)

    def SubBytes(self, state):
        """
        SubBytes transformation
        """
        return [[self.sbox[byte] for byte in word] for word in state]
    
    def ShiftRows(self, state):
        """
        ShiftRows transformation
        """
        n = [word[:] for word in state] # temp state

        for i in range(self.Nb):
            for j in range(4): # shift rows by i
                n[i][j] = state[i][(i + j) % self.Nb]

        return n
    
    def MixColumns(self, state):
        """
        MixColumns transformation
        """
        n = [[0] * self.Nb for _ in state]

        for c in range(self.Nb):
            s0 = state[0][c]
            s1 = state[1][c]
            s2 = state[2][c]
            s3 = state[3][c]

            n[0][c] = gf_mult(2, s0) ^ gf_mult(3, s1) ^ s2 ^ s3
            n[1][c] = s0 ^ gf_mult(2, s1) ^ gf_mult(3, s2) ^ s3
            n[2][c] = s0 ^ s1 ^ gf_mult(2, s2) ^ gf_mult(3, s3)
            n[3][c] = gf_mult(3, s0) ^ s1 ^ s2 ^ gf_mult(2, s3)

        return n

    def AddRoundKey(self, state, keys):
        s_ = [[None for _ in range(4)] for i in range(self.Nb)]

        k_ = [word_to_bytes(word) for word in keys]

        for c in range(self.Nb):
            for i in range(4):
                s_[i][c] = state[i][c] ^ k_[c][i]

        return s_

    def encrypt(self, input_):
        self.input_ = input_
        initial_state = process_input_hex(input_)

        # Initial round (Round 0)
        state = self.AddRoundKey(initial_state, self.W[:4])

        # Round 1 to Nr-1
        for r in range(1, self.Nr):
            state = self.SubBytes(state)
            state = self.ShiftRows(state)
            state = self.MixColumns(state)
            state = self.AddRoundKey(state, self.W[4*r : 4*r + 4])

        # Final round (Round Nr)
        state = self.SubBytes(state)
        state = self.ShiftRows(state)
        state = self.AddRoundKey(state, self.W[-4:])

        return state


if __name__ == "__main__":
    key = '000102030405060708090a0b0c0d0e0f'
    input_ = '00112233445566778899aabbccddeeff'

    aes = AES()
    aes.enter_key(key)
    final = aes.encrypt(input_)

    print(f"key:\t\t{key}")
    print(f"plaintext:\t{input_}")
    print(f"ciphertext:\t{state_to_hex(final)}")


