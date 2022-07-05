<?php

namespace App\Http\Controllers;
use App\Models\Category;

use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function addCategory(Request $request){
        
        $category = new Category;
        $category->category_name = $request->category_name;
        $category->save();

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function getCategories(Request $request){
        $categories = Category::all();
        return response()->json([
            "success" => true,
            "categories" => $categories
        ], 200);
    }

}
