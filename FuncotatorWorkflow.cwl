#!/usr/bin/env cwl-runner
cwlVersion: v1.0

class: Workflow
label: TVariant Calling

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  VCFin: File

steps:

  DownloadSources:
    run: FuncotatorDownloader.cwl
    in:
      Somatic:
        default: true
      Validate:
        default: true
      Extract:
        default: true
    out:
      [funcotator_sources]

  DownloadReference:
    run: wget.cwl
    in:
      in_url:
        default: "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz"
    out:
      [out_wget]

  UnzipReference:
    run: Gunzip.cwl
    in:
#      InputFile: DownloadReference/out_wget
      InputFile:
        source: DownloadReference/out_wget
        valueFrom: ${return [self]}
    out:
      [unzipped_file]

  SamtoolsIndex:
    run: Samtools-index.cwl
    in:
      input: UnzipReference/unzipped_file
    out:
      [index_fai]


  GATK-CreateSequenceDictionary:
    run: GATK-CreateSequenceDictionary.cwl
    in:
      RefFasta: SamtoolsIndex/index_fai
    out:
      [fastaDict]


  Funcotate:
    run: Funcotator.cwl
    in:
#      Reference: SamtoolsIndex/index_fai
      Reference: GATK-CreateSequenceDictionary/fastaDict
      RefVersion:
        default: "hg19"
      Output:
        default: "variants.funcotated.vcf"
      InputVCF: VCFin
      DataSources: DownloadSources/funcotator_sources
      OutputFormat:
        default: VCF
    out:
      [annotated_variants]


outputs:
  annotated_variants:
    type: File[]
    outputSource: Funcotate/annotated_variants
