# Snakefile

SAMPLES = ["sample1", "sample2", "sample3"]

rule all:
    input:
        expand("results/{sample}_gc.txt", sample=SAMPLES)

rule calculate_gc:
    input:
        fasta = "data/{sample}.fasta"
    output:
        report = "results/{sample}_gc.txt"
    shell:
        # We invoke Docker explicitly, mounting the workspace pwd relative to the executor system
        # This completely decouples Snakemake from needing internal container dependencies!
        """
        docker run --rm \
          -v $(pwd)/data:/app/data \
          -v $(pwd)/results:/app/results \
          guangqi99/bio-script:1.0 /app/data/{wildcards.sample}.fasta /app/results/{wildcards.sample}_gc.txt
        """

