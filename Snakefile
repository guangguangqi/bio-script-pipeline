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
    resources:
        # Requesting a valid 1 CPU so the Kubernetes API accepts it
        kubernetes_cpu = 1,
        kubernetes_mem = "256M"
    container:
        "docker://guangqi99/bio-script:1.0"
    shell:
        "python /app/count_bases.py {input.fasta} {output.report}"

