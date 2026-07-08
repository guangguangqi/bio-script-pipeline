# Snakefile

# Global docker definition
container: "docker://guangqi99/bio-script:1.0"

rule all:
    input:
        "results/sample1_gc.txt"

rule calculate_gc:
    input:
        fasta = "data/sample1.fasta"
    output:
        report = "results/sample1_gc.txt"
    shell:
        # CHANGE: The entrypoint handles "python /app/count_bases.py"
        # We only pass the parameters. Snakemake automatically passes these paths into the container.
        " {input.fasta} {output.report}"

