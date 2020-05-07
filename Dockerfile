# 1.jarファイルの生成
FROM maven:3.6.1-jdk-8 as builder
RUN mkdir -p /opt/java/src
  # 必要なソースを /opt/java へコピー
COPY . /opt/java/
  # mvn install によりtargetディレクトリにjarが生成される
RUN cd /opt/java && mvn install

FROM openjdk:8-jre-alpine
RUN mkdir -p /opt/app/
# 2.builderコンテナの中にあるjarファイルを /opt/app/ にコピー
COPY --from=builder /opt/java/target/hello-world-0.0.1.jar /opt/app/
  # 8080ポートを開ける
EXPOSE 8080
# 3.アプリを実行
CMD  ["java","-jar","/opt/app/hello-world-0.0.1.jar"]