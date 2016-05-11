from flask import Flask, jsonify
from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext

app = Flask(__name__)

conf = SparkConf().setAppName('csv viewer')
sc = SparkContext(conf=conf)
# spark-submit", "--master", "yarn", "--proxy-user", "shelly", "--deploy-mode", "cluster", "--packages", "com.databricks:spark-csv_2.10:1.4.0"
sqlContext = SQLContext(sc)
csv_file = 'panama/offshore_leaks_csvs/Entities.csv'
df = sqlContext.read.format('com.databricks.spark.csv').options(header='true', inferschema='true').load(csv_file)


@app.route('/table', methods=['GET'])
def table():
    result = df.select('name', 'status').limit(10).toJSON().collect()
    return jsonify(result)

if __name__ == '__main__':
    try:
        app.run(port=8080)
    finally:
        sc.stop()
