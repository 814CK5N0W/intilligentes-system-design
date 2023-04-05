flask-ver:
	python -c "import flask; print(flask.__version__)"

start:
	python3 -m venv venv
	cd venv && source bin/activate.fish
	cd ..
	pip install -r requirements.txt
	export FLASK_APP=start
	export FLASK_ENV=development
	cd app && flask run

buildDocker: 
	docker build -t rns .

runDocker:
	docker run -p 127.0.0.1:5000:5000/udp -p 127.0.0.1:5000:5000/tcp --name rns rns

clearDocker:
	docker system prune -f
	docker volume prune -f