#!/bin/sh


HOST=127.0.0.1
CLI=./grpc_cli

call() {
  PORT=$1
  shift
  $CLI call ${HOST}:${PORT} fibonacci.Greeter/SayHello <<EOF
$@
EOF
}

# ─────────────────────────────────────────
# 1. chameleon (50051)
if [ "$1" = "chameleon" ]; then
  echo "Invoking chameleon"
  call 50051 "name: '100'"
fi

# 2. pagerank (50052)
if [ "$1" = "pagerank" ]; then
  echo "Invoking pagerank"
  call 50052 "name: '50000'"
fi

# 3. fibonacci (50053)
if [ "$1" = "fibonacci" ]; then
  echo "Invoking fibonacci"
  call 50053 "name: '200'"
fi

# 4. cnn_image_classification (50054)
if [ "$1" = "cnn_image_classification" ]; then
  echo "Invoking cnn_image_classification"
  call 50054 "name: 'low'"
fi

# 5. bfs (50055)
if [ "$1" = "bfs" ]; then
  echo "Invoking bfs"
  call 50055 "name: '50000'"
fi

# 6. matmul (50056)
if [ "$1" = "matmul" ]; then
  echo "Invoking matmul"
  call 50056 "name: '2000'"
fi

# 7. ml_video_face_detection (50057)
if [ "$1" = "ml_video_face_detection" ]; then
  echo "Invoking ml_video_face_detection"
  call 50057 "name: '$2'"
fi

# 8. image_processing (50058)
if [ "$1" = "image_processing_low" ]; then
  echo "Invoking image_processing low"
  call 50058 "name: 'low'"
fi

if [ "$1" = "image_processing_hd" ]; then
  echo "Invoking image_processing hd"
  call 50058 "name: 'hd'"
fi

# 9. model_training (50059)
if [ "$1" = "model_training_10mb" ]; then
  echo "Invoking model_training 10MB"
  call 50059 "name: 'reviews10mb.csv'"
fi

if [ "$1" = "model_training_20mb" ]; then
  echo "Invoking model_training 20MB"
  call 50059 "name: 'reviews20mb.csv'"
fi

# 10. dna_visualization (50060)
if [ "$1" = "dna_visualization_big" ]; then
  echo "Invoking dna_visualization_big"
  call 50060 "name: 'big'"
fi

if [ "$1" = "dna_visualization_verybig" ]; then
  echo "Invoking dna_visualization_verybig"
  call 50060 "name: 'verybig'"
fi

# 11. ml_lr_prediction (50061)
if [ "$1" = "ml_serving" ]; then
  echo "Invoking ml_serving"
  call 50061 "name: 'dummy'"
fi

# 12. video_processing (50062)
if [ "$1" = "video_processing" ]; then
  echo "Invoking video_processing"
  call 50062 "name: 'lowres2'"
fi

# 13. rnn_generate_character_level (50063)
if [ "$1" = "rnn_serving" ]; then
  echo "Invoking rnn_serving"
  call 50063 "name: 'hello world'"
fi

# 14. python_list (50064)
if [ "$1" = "python_list" ]; then
  echo "Invoking python_list"
  call 50064 "name: '200'"
fi
