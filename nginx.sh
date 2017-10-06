# install nginx
yum -y install nginx

# config for leanote
vi /etc/nginx/conf.d/note.conf

upstream  note.silasq.top  {                                                                           
        server   localhost:9000;
    }
server
    {
        listen  80;
        server_name  note.silasq.top;

        location / {
            proxy_pass        http://note.silasq.top;
            proxy_set_header   Host             $host;
            proxy_set_header   X-Real-IP        $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        }
    }

#config for rss
vi /etc/nginx/conf.d/rss.conf

server {
listen 80;
server_name rss.silasq.top;
location / {
root /var/www/html/;
}
}
