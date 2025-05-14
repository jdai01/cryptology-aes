from aes import aes_properties

IRRED_POLY = aes_properties["irred_poly"]

def gf_mult(a, b):
    """
    Galois Field (GF) multiplication
    """
    result = 0
    for i in range(8):
        if b & 1:
            result ^= a
        a <<= 1
        if a & 0x100:
            a ^= IRRED_POLY
        b >>= 1
    return result & 0xFF  # Ensure the result is within 0x00 to 0xFF


def generate_gf(primitive_element):
    """
    Extension field of 2^8, multiplicative of primitive_element
    """
    field = [0]  # Start with 0
    element = primitive_element

    for _ in range(1, 256):
        field.append(element)
        element = gf_mult(element, primitive_element)

    return field