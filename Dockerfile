#Builder Stage
# as builder 는 From 부터 다음 From까지 Builder stage 라는것을 나타냄
# usr/src/app/build 에 위치할 예정
FROM node:alpine as builder  
WORKDIR '/usr/src/app'   
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

#Run Stage
FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

#--from 다른 스테이지에 있는 파일을 복사할때 다른 stage 이름 명시 -> 앞에 경로파일은 빌더에서 오는것이다라고 나타내는 것임
# /usr/src/app/build 에서 nginx의 /usr/share/nginx/html 이곳으로 복사한다

#Nginx는 80번이 기본 포트이므로 docker run -p 8080:80 deankim0507
