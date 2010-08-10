# ugly functions to navigate in buildout trees
function 5r() {
    while [ ! -d parts ]; do
        cd ..;
    done
}
function 5p() {
    5r;
    cd parts/products-erp5;
}
function 5e() {
    5r;
    cd parts/products-erp5/ERP5;
}
function 5t() {
    5r;
    cd parts/products-erp5/ERP5Type;
}
function 5i() {
    5r;
    cd parts/erp5_instance;
}

