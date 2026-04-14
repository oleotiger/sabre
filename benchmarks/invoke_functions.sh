#!/usr/bin/env bash
set -euo pipefail

# 用法：
#   ./benchmarks/invoke_functions.sh <function_name> [name]
# 说明：
#   - function_name: benchmarks 下的函数目录名
#   - name: 传给 gRPC SayHello 的 request.name
#   - 未传 name 时，本脚本会按 server.py 的逻辑使用“默认值”
# 依赖：grpcurl（服务端需开启 reflection；当前各 server.py 已开启）

HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-50051}"
METHOD="fibonacci.Greeter/SayHello"

invoke_raw() {
  local name="$1"
  grpcurl -plaintext -d "{\"name\":\"${name}\"}" "${HOST}:${PORT}" "${METHOD}"
}

# bfs
# 支持参数：
#   - 整数字符串（图规模 size）
# 可选项：
#   - 任意非整数字符串（触发兜底）
# 默认参数（不配置时）：50000
invoke_bfs() {
  local name="${1:-50000}"
  invoke_raw "$name"
}

# chameleon
# 支持参数：
#   - 整数字符串 n（rows 和 columns 在 [0, n] 内随机）
# 可选项：
#   - 任意非整数字符串（触发兜底）
# 默认参数（不配置时）：随机 rows/columns ∈ [0,100]
invoke_chameleon() {
  local name="${1:-default}"
  invoke_raw "$name"
}

# cnn_image_classification
# 支持参数：
#   - record | replay | hd
# 可选项：
#   - 其他任意值（走 low 分辨率图片轮转）
# 默认参数（不配置时）：low_images[0]（首次）
invoke_cnn_image_classification() {
  local name="${1:-default}"
  invoke_raw "$name"
}

# dna_visualization
# 支持参数：
#   - record | replay | small | medium | big | verybig
# 可选项：
#   - 其他任意值（按内部列表轮转）
# 默认参数（不配置时）：bacillus_subtilis.fasta（首次）
invoke_dna_visualization() {
  local name="${1:-default}"
  invoke_raw "$name"
}

# fibonacci
# 支持参数：
#   - 整数字符串 x
# 可选项：无
# 默认参数（不配置时）：无（server.py 对非整数无保护，会报错）
invoke_fibonacci() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    echo "fibonacci 需要显式传入整数参数，例如: ./benchmarks/invoke_functions.sh fibonacci 30" >&2
    return 2
  fi
  invoke_raw "$name"
}

# image_processing
# 支持参数：
#   - record | replay | hd
# 可选项：
#   - 其他任意值（走 low 分辨率图片轮转）
# 默认参数（不配置时）：low_images[0]（首次）
invoke_image_processing() {
  local name="${1:-default}"
  invoke_raw "$name"
}

# matmul
# 支持参数：
#   - 整数字符串 N（矩阵维度）
# 可选项：
#   - 任意非整数字符串（触发兜底）
# 默认参数（不配置时）：128
invoke_matmul() {
  local name="${1:-128}"
  invoke_raw "$name"
}

# ml_lr_prediction
# 支持参数：
#   - 任意文本（情感预测输入）
# 可选项：无
# 默认参数（不配置时）：空字符串 ""
invoke_ml_lr_prediction() {
  local name="${1:-}"
  invoke_raw "$name"
}

# ml_video_face_detection
# 支持参数：
#   - record | replay | hd2 | hd10 | hd30 | lowres2 | lowreshd10 | lowres30
# 可选项：
#   - 其他任意值（按内部视频列表轮转）
# 默认参数（不配置时）：SampleVideo_1280x720_30mb.mp4（首次）
invoke_ml_video_face_detection() {
  local name="${1:-default}"
  invoke_raw "$name"
}

# model_training
# 支持参数：
#   - reviews10mb.csv | reviews20mb.csv | reviews50mb.csv | reviews100mb.csv
# 可选项：
#   - 其他任意值（触发兜底）
# 默认参数（不配置时）：reviews10mb.csv
invoke_model_training() {
  local name="${1:-reviews10mb.csv}"
  invoke_raw "$name"
}

# pagerank
# 支持参数：
#   - 整数字符串（图规模 size）
# 可选项：
#   - 任意非整数字符串（触发兜底）
# 默认参数（不配置时）：50000
invoke_pagerank() {
  local name="${1:-50000}"
  invoke_raw "$name"
}

# python_list
# 支持参数：
#   - 整数字符串 x
# 可选项：无
# 默认参数（不配置时）：无（server.py 对非整数无保护，会报错）
invoke_python_list() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    echo "python_list 需要显式传入整数参数，例如: ./benchmarks/invoke_functions.sh python_list 30" >&2
    return 2
  fi
  invoke_raw "$name"
}

# rnn_generate_character_level
# 支持参数：
#   - 任意字符串（input_chars）
# 可选项：无
# 默认参数（不配置时）：空字符串 ""
invoke_rnn_generate_character_level() {
  local name="${1:-}"
  invoke_raw "$name"
}

# video_processing
# 支持参数：
#   - record | replay | hd2 | hd10 | hd30 | lowres2 | lowreshd10 | lowres30
# 可选项：
#   - 其他任意值（按内部视频列表轮转）
# 默认参数（不配置时）：SampleVideo_1280x720_30mb.mp4（首次）
invoke_video_processing() {
  local name="${1:-default}"
  invoke_raw "$name"
}

usage() {
  cat <<'USAGE'
Usage:
  HOST=127.0.0.1 PORT=50051 ./benchmarks/invoke_functions.sh <function_name> [name]

Available function_name:
  bfs
  chameleon
  cnn_image_classification
  dna_visualization
  fibonacci
  image_processing
  matmul
  ml_lr_prediction
  ml_video_face_detection
  model_training
  pagerank
  python_list
  rnn_generate_character_level
  video_processing
USAGE
}

main() {
  local fn="${1:-}"
  local name="${2:-}"

  if [[ -z "$fn" ]]; then
    usage
    exit 1
  fi

  case "$fn" in
    bfs|chameleon|cnn_image_classification|dna_visualization|fibonacci|image_processing|matmul|ml_lr_prediction|ml_video_face_detection|model_training|pagerank|python_list|rnn_generate_character_level|video_processing)
      "invoke_${fn}" "$name"
      ;;
    *)
      echo "Unknown function_name: $fn" >&2
      usage
      exit 1
      ;;
  esac
}

main "$@"
