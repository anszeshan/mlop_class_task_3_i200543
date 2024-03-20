# Variables
PYTHON = python3
FLASK_APP = main.py

# Targets
clean:
    @echo "Cleaning up..."
    rm -rf __pycache__ *.csv

install:
    @echo "Installing dependencies..."
    pip install pandas flask scikit-learn

clean_data:
    @echo "Cleaning data..."
    $(PYTHON) -c "from app import clean_data; clean_data('project.xlsx', 'cleaned_data.csv')"

train_model:
    @echo "Training linear regression model..."
    $(PYTHON) -c "from app import train_linear_regression_model; train_linear_regression_model('cleaned_data.csv')"

predict:
    @echo "Making prediction..."
    $(PYTHON) -c "from app import predict_field, model, label_encoder; \
        import pandas as pd; \
        new_data = pd.DataFrame({'Sr. No.': [1], 'History': [3], 'Geography': [4], \
        'Political Science': [5], 'Economics': [8], 'Maths': [20], 'Physics': [12], \
        'Chemistry': [10], 'Biology': [30], 'Accounts': [45], 'Physical Education': [45], \
        'Sports': [14], 'Indoor sports': [45], 'Art and Craft': [78], 'Music': [20], 'Dance': [91]}); \
        predictions = predict_field(model, new_data, label_encoder); \
        print(predictions[0])"

run_server:
    @echo "Running Flask server..."
    export FLASK_APP=$(FLASK_APP) && flask run

.PHONY: clean install clean_data train_model predict run_server
