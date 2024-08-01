from pyspark.sql import SparkSession
import glob

spark = SparkSession.builder \
        .appName("PythonWordCount") \
        .master('spark://spark-master:7077') \
        .getOrCreate()
sc = spark.sparkContext
sc.setLogLevel("WARN")

print(f'cores are: {sc.defaultParallelism}')

df=spark.read.options("header",True).csv('jobs/CAvideos.csv')
print(df.columns)
spark.stop()