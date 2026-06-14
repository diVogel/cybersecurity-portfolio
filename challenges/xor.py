import string
from pwn import *

ch = string.ascii_letters + string.digits
enc_flag = bytes.fromhex("673f0431340216252430760f3d0b3047432a212772193b79255f3b3022114103307a31410f063839")
part_flag = b'THM{'

part_key = xor(enc_flag,part_flag)[:4]

for c in ch:
    key = part_key + c.encode()
    dec_flag = xor(enc_flag,key).decode()

    if dec_flag[-1] == '}':
        print(f"key : {key.decode()}")
        print(f"flag : {dec_flag}")