# count_bases.py
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r') as f:
    lines = f.readlines()

sequence = lines[1].strip().upper()

g_count = sequence.count('G')
c_count = sequence.count('C')
total = len(sequence)
gc_content = (g_count + c_count) / total * 100

with open(output_file, 'w') as out:
    out.write(f"Sequence: {sequence}\n")
    out.write(f"GC Content: {gc_content}%\n")

print(f"Successfully processed {input_file}. GC Content is {gc_content}%.")

