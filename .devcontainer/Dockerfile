# Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# ユーザーとグループのIDを必要に応じて更新
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# UID/GIDを更新して必要ならユーザーを作成
RUN if [ "$USER_UID" != "1000" ] || [ "$USER_GID" != "1000" ]; then \
    groupmod -o -g "$USER_GID" "$USERNAME" || (addgroup -g "$USER_GID" "$USERNAME" && groupmod -o -g "$USER_GID" "$USERNAME"); \
    usermod -o -u "$USER_UID" -g "$USER_GID" "$USERNAME" || (adduser -u "$USER_UID" -D -G "$USERNAME" "$USERNAME" && usermod -o -u "$USER_UID" -g "$USER_GID" "$USERNAME"); \
    chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi

# ワークスペースディレクトリの設定
WORKDIR /workspace

# Rails環境のsetup
## rbenv Install
RUN sudo apt update && sudo apt install -y rbenv libffi-dev libyaml-dev ruby-dev build-essential libmysqlclient-dev
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN . ~/.bashrc
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

## ruby Install
RUN rbenv install 3.3.1
RUN rbenv global 3.3.1

## bundler Install
RUN gem install bundler -v 2.5.9

## rails Install
RUN gem install rails -v 7.1.3

## rails用のPrettier設定 - nodejs Install
RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN gem install bundler prettier_print syntax_tree syntax_tree-haml syntax_tree-rbs rubocop

## permissionの変更
RUN sudo chown vscode:vscode -R /var/lib/gems
RUN sudo chown vscode:vscode -R /usr/local/bin
