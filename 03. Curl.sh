curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"ping"}'
curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"ping","parameter_1":"30"}'
curl -X POST "http://localhost:5050/api/command" -H "Content-Type: application/json" -d '{"command":"exit"}'

curl -X POST "http://localhost:5050/api/1.0/command" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d @body.json

curl -X POST "http://localhost:5050/api/1.0/command" \
        -H @header.txt \
        -d @body.json

curl -X GET "http://localhost:5050/api/1.0"

curl -v -X GET -G "http://localhost:5050/api/1.0/ping" \
        --data-urlencode "a=Тест 0&Тест 1" \
        --data-urlencode "b=Тест 2" \
        --data-urlencode "c=Тест 3,Тест 4" \
        -H "Accept: application/json"

curl -v -X GET -G "http://localhost:5050/api/1.0/ping/Тест!" \
        --url-query "a=Тест 0&Тест 1" \
        --url-query "b=Тест 2" \
        --url-query "c=Тест 3,Тест 4" \
        -H "Accept: application/json"







