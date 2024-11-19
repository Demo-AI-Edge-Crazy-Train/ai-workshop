#!/bin/sh
for i in {1..40};
do
    sed "s/USER_ID/user$i/g" namespace.yaml > tmp-ns.yaml;
    sed "s/USER_ID/user$i/g" pvc.yaml > tmp-pvc.yaml;
    oc apply -f tmp-ns.yaml;
    oc apply -f tmp-pvc.yaml;
    oc -n user$i adm policy add-role-to-user admin user$i;
    rm tmp-ns.yaml tmp-pvc.yaml;
done;
