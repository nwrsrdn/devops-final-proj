#!/bin/sh

# ./scripts/01-build-image.sh <image-name> <version>

# Build Results App
if [ $1 == 'result' ]
then
  docker build --platform linux/amd64 -t result-app:$2 ./apps/result --progress=plain --no-cache
  docker image tag result-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/result:$2
  # docker image tag result-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/result:latest
  docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/result:$2
  # docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/result:latest
fi

# Build Votes App
if [ $1 == 'vote' ]
then
  docker build --platform linux/amd64 -t vote-app:$2 ./apps/vote --progress=plain --no-cache
  docker image tag vote-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/vote:$2
  # docker image tag vote-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/vote:latest
  docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/vote:$2
  # docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/vote:latest
fi

# Build Worker App
if [ $1 == 'worker' ]
then
  docker build --platform linux/amd64 -t worker-app:$2 ./apps/worker --progress=plain --no-cache
  docker image tag worker-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/worker:$2
  # docker image tag worker-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/worker:latest
  docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/worker:$2
  # docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/worker:latest
fi

# Build Seeder App
if [ $1 == 'seeder' ]
then
  docker build --platform linux/amd64 -t seeder-app:$2 ./apps/common/seeder --progress=plain --no-cache
  docker image tag seeder-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/seeder:$2
  # docker image tag seeder-app:$2 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/seeder:latest
  docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/seeder:$2
  # docker push 966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/seeder:latest
fi
