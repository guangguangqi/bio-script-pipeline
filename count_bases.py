# count_bases.py
import sys
import os

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r') as f:
    lines = f.readlines()

sequence = lines[1].strip().upper()

g_count = sequence.count('G')
c_count = sequence.count('C')
total = len(sequence)
gc_content = (g_count + c_count) / total * 100

output_dir = os.path.dirname(output_file)
if output_dir:
    os.makedirs(output_dir, exist_ok=True)

# Write the final result to the output file
with open(output_file, 'w') as out:
    out.write(f"Sequence: {sequence}\n")
    out.write(f"GC Content: {gc_content}%\n")

# FIX: Print the exact same format to standard output so Jenkins can capture it easily
print(f"Sequence: {sequence}")
print(f"GC Content: {gc_content}%")

