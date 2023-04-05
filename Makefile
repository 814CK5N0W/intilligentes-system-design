
r=python3
p=pip
d=docker
p=5000
addr=127.0.0.1
container_name=rns
container_alias=rns

venv: venv/touchfile

data:
	

venv/touchfile: requirements.txt
	test -d venv || virtualenv venv
	. venv/bin/activate; pip install -r requirements.txt
	touch venv/touchfile

test: venv
	. venv/bin/activate; python test/app.test.py

run: venv
	. venv/bin/activate; cd app; flask run

clean:
	rm -rf venv/
	find . -iname "*.pyc" -delete

imageRecognizer: 
	docker build -t rns .
	docker run -p $(addr):$(p):$(p)/udp -p $(addr):$(p):$(p)/tcp --name $(container_alias) $(container_name)

