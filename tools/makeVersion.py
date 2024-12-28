import sys, subprocess


template = """{
    .rom_hash = 0x%sULL,
    .internal_name = "%s",
    .game_id = u8"%s.us",
    .is_enabled = true,
    .entrypoint_address = get_entrypoint_address(),
    .entrypoint = recomp_entrypoint,
},
"""
rom = sys.argv[1]


xxhproc = subprocess.Popen(["xxhsum", "-H3", rom], stdout=subprocess.PIPE)
xxhsum = xxhproc.communicate()[0].decode('ascii')
xxhsum = xxhsum[:-1].split()[-1]

fb = []
with open(rom, "rb") as f:
    fb = f.read()

internal_name = fb[0x20:0x34].decode('ascii')
game_id = fb[0x3B:0x40].decode('ascii')

print(template % (xxhsum, internal_name, game_id))
