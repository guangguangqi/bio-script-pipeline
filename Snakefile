# Snakefile

SAMPLES = ["sample1", "sample2", "sample3"]

rule all:
    input:
        expand("results/{sample}_gc.txt", sample=SAMPLES)

rule calculate_gc:
    input:
        # Snakemake still tracks local files for the DAG structure
        fasta = "data/{sample}.fasta"
    output:
        report = "results/{sample}_gc.txt"
    shell:
        # NO MORE -v VOLUMES! We let the container read its own internal file.
        # We use a standard Linux redirect (>) to capture the container's output report file.
        """
        docker run --rm guangqi99/bio-script:1.0 /app/data/{wildcards.sample}.fasta /app/results/{wildcards.sample}_gc.txt > {output.report}
        """

