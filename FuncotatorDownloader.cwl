#!/usr/bin/env cwl-runner
cwlVersion: v1.1
class: CommandLineTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

hints:
  arv:APIRequirement: {}

requirements:
  DockerRequirement:
    dockerPull: "broadinstitute/gatk:4.1.7.0"
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  ResourceRequirement:
    ramMin: 40000  # [MB]
    coresMin: 4        # [cores]
    tmpdirMin: 10000   # [MB]

inputs:
  # REQUIRED ARGS

  Somatic:
    type: boolean?
    default: true
    inputBinding:
      prefix: "--somatic"

  Validate:
    type: boolean?
    default: true
    inputBinding:
      prefix: "--validate-integrity"

  Extract:
    type: boolean?
    default: true
    inputBinding:
      prefix: "--extract-after-download"


baseCommand: ["/gatk/gatk"]

arguments:
  - valueFrom: "FuncotatorDataSourceDownloader"
    position: -1

outputs:
  - id: funcotator_sources
    type: Directory
    outputBinding:
      glob: "funcotator_dataSources.v1.6.20190124s"
#      glob: $(".")
