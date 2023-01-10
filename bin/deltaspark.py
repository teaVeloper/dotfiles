import pyspark
from delta import *

builder = (
    pyspark.sql.SparkSession.builder.appName("DeltaSparkShell")
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config(
        "spark.sql.catalog.spark_catalog",
        "org.apache.spark.sql.delta.catalog.DeltaCatalog",
    )
    .enableHiveSupport()
)
spark = configure_spark_with_delta_pip(builder).getOrCreate()
