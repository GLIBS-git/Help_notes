curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"ping"}'
curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"ping","parameter_1":"30"}'
curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"exit"}'

curl -X POST "http://localhost:5050/api/v1/command" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d @body.json

curl -X POST "http://localhost:5050/api/1.0/command" \
        -H @header.txt \
        -d @body.json

curl -X GET "http://localhost:5050/api/v1"

curl -v -X GET -G "http://localhost:5050/api/v1/ping" \
        --data-urlencode "a=Тест 0&Тест 1" \
        --data-urlencode "b=Тест 2" \
        --data-urlencode "c=Тест 3,Тест 4" \
        -H "Accept: application/json"

curl -v -X GET "http://localhost:5050/api/v1/ping/Тест!" \
        --url-query "a=Тест 0&Тест 1" \
        --url-query "b=Тест 2" \
        --url-query "c=Тест 3,Тест 4" \
        -H "Accept: application/json"

# -v is better than -i
curl -i --connect-timeout 5 "http://192.168.0.157:5050/api/v1"
curl -v --connect-timeout 5 "http://192.168.0.157:5050/api/v1" \
curl -v --connect-timeout 5 "http://192.168.0.157:5050/api/v1/ping" \
        --url-query "delay=5" \
        --url-query "output=json"
        --url-query "output=text"

curl -v --connect-timeout 5 "http://localhost:5050/api/v1/test" \
        --url-query "a=Тест 0&Тест 1" \
        --url-query "b=Тест 2" \
        --url-query "c=Тест 3,Тест 4" \
        -H "Accept: application/json"

# Linux style
curl -v --connect-timeout 5 "http://localhost:5050/api/v1/test" \
        --url-query "a=Тест 0&Тест 1" \
        --url-query "b=Тест 2" \
        --url-query "c=Тест 3,Тест 4" \
        --url-query "a=Тест 5&Тест 6" \
        -H "Accept: application/json"

# Windows style
curl -v --connect-timeout 5 "http://localhost:5050/api/v1/test" ^
        --url-query "a=Тест 0&Тест 1" ^
        --url-query "b=Тест 2" ^
        --url-query "c=Тест 3,Тест 4" ^
        --url-query "a=Тест 5&Тест 6" ^
        -H "Accept: application/json"




