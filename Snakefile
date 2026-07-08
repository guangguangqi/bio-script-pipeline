# Snakefile

# Define the samples we want to process in parallel
SAMPLES = ["sample1", "sample2", "sample3"]

rule all:
    input:
        expand("results/{sample}_gc.txt", sample=SAMPLES)

rule calculate_gc:
    input:
        fasta = "data/{sample}.fasta"
    output:
        report = "results/{sample}_gc.txt"
    resources:
        # Give Kubernetes small resource boundaries so your laptop stays happy
        kubernetes_cpu = 0.5,
        kubernetes_mem = "256M"
    container:
        "docker://guangqi99/bio-script:1.0"
    shell:
        # We read from the image's internal script, passing dynamic inputs/outputs
        "python /app/count_bases.py {input.fasta} {output.report}"

