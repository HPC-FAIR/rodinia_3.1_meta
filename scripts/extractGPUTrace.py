#!/opt/anaconda3/bin/python3
import sys
import glob
import re
import csv

filenames = sorted(glob.glob('*.log'))

csvfilename = 'GPUDataSet.csv'
# Find beginning of event result
event = re.compile('Event result:')
# Find beginning of metric result
metric = re.compile('Metric result:')


csvcolumn = ["kernel","InputData","thread","event/metric", "invocation", "min", "max", "avg" ]

with open(csvfilename, 'w') as output_file:
  writer = csv.writer(output_file)
  writer.writerow(csvcolumn)


for f1 in filenames:
    thread = re.split("[_]|.log", f1)[0]
    inputData = re.split("[_]|.log", f1)[1]
#    print(variant, inputData) 
    with open(csvfilename, 'a') as fout:
      with open(f1, "r") as f:
          lines = f.readlines()
          inEventResult = None
          inMetricResult = None
          for line_i, line  in enumerate(lines):
            match = re.search("Kernel: ",line)
            if match:
              kernelName = line.split("Kernel: ",1)[1]
              kernelName = kernelName.strip('\n') 
            for match in re.finditer(event,line):
              inEventResult = True
              inMetricResult = False
              # print(line_i, line)
            for match in re.finditer(metric,line):
              inEventResult = False
              inMetricResult = True
              # print(line_i, line)
            ##  process events
            if(inEventResult):	
              elements = line.split()
              if len(elements) == 6:
                # remove total, it can be retrieved by invocation * avg 
                del elements[5] 
                elements.insert(0,thread)
                elements.insert(0,inputData)
                elements.insert(0,kernelName)
                #print(elements)
                newline = ','.join(elements)
                fout.write(newline)
                fout.write('\n') 
            ##  process metrics
            if(inMetricResult):	
              elements = line.split()
              if len(elements) == 6:
                # remove metric description 
                del elements[2] 
                elements.insert(0,thread)
                elements.insert(0,inputData)
                elements.insert(0,kernelName)
                #print(elements)
                newline = ','.join(elements)
                fout.write(newline)
                fout.write('\n') 
