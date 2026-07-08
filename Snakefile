# Snakefile

rule all:
    input:
        "results/sample1_gc.txt"

rule calculate_gc:
    input:
        fasta = "data/sample1.fasta"
    output:
        report = "results/sample1_gc.txt"
    shell:
        # We will let the Jenkins execution environment handle the Docker wrapper command directly
        "python /app/count_bases.py {input.fasta} {output.report}"

