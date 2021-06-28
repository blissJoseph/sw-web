#어떤 이미지로부터 새로운 이미지를 생성할지를 지정
FROM node:lts-alpine

RUN mkdir -p /backend
WORKDIR /backend
ADD . /backend
RUN npm install

EXPOSE 3000 80

#컨테이너에서 실행될 명령을 지정
CMD ["npm", "start"]