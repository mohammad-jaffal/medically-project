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

}
