import numpy as np
import binascii

def process_str(string):
    return string.replace(" ", "")

def process_key(key, Nk=4):
    try:
        key = process_str(key)
        
        # Convert hex string to list of integers
        bytes_list = [int(key[i:i+2], 16) for i in range(0, len(key), 2)]

        # Reshape into a (Nk, 4) NumPy array
        return np.array(bytes_list).reshape((Nk, 4))
    except:
        raise Exception("Key must be hexadecimal.")

def process_input_hex(input_hex):
    try:
        return process_key(input_hex).T
    except:
        raise Exception("Input must be hexadecimal.")


def bytes_to_word(bytes_list):
    """
    Converts a list of 4 bytes into a 32-bit word.
    """
    if len(bytes_list) != 4:
        raise Exception("Use case only valid for AES-128 (4-byte word)")

    return (bytes_list[0] << 24) | (bytes_list[1] << 16) | (bytes_list[2] << 8) | bytes_list[3]

def word_to_bytes(word):
    """
    Converts a 32-bit word into a list of 4 bytes.
    """
    return [
        (word >> 24) & 0xFF,    # Most significant byte
        (word >> 16) & 0xFF,
        (word >> 8) & 0xFF,
        word & 0xFF             # Least significant byte
    ]

def state_to_hex(state):
    """
    Convert AES state matrix (4x4 bytes) to a hex string
    """
    state = np.array(state)
    flat = state.T.flatten()
    return "".join(f"{byte:02X}" for byte in flat)

