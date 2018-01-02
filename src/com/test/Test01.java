package com.test;

import com.emy.dao.product.impl.ProductCategoryDaoImpl;
import com.emy.entity.ProductCategory;

import java.util.List;

public class Test01 {

    public static void main(String[] args) {

        ProductCategoryDaoImpl pc = new ProductCategoryDaoImpl();
        List<ProductCategory> pcs = pc.getAll();
        for (ProductCategory pct : pcs) {
            System.out.println(pct.getId());
            System.out.println(pct.getName());
        }





    }


}


