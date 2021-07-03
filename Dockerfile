FROM ruby:2.7.2 AS wh2w-api

ARG USER_ID
ARG GROUP_ID
ARG GITHUB_USER
ARG GITHUB_TOKEN

RUN echo $GITHUB_USER

#RUN addgroup --gid $GROUP_ID user
#RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
#RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

COPY ./ ./
RUN rm -rf node_modules
RUN gem install rails bundler
RUN bundle config set --global rubygems.pkg.github.com $GITHUB_USER:$GITHUB_TOKEN
RUN bundle config rubygems.pkg.github.com && bundle install
#RUN yarn install
#RUN chown -R user:user /opt/app

#USER $USER_ID
CMD ["/bin/bash"]