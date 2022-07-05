<?php

namespace App\Http\Controllers;
use App\Models\Favorite;

use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    public function addFavorite(Request $request){
        
        $favorite = new Favorite;
        $favorite->user_id = $request->user_id;
        $favorite->doctor_id = $request->doctor_id;
        $favorite->save();

        return response()->json([
            "success" => true,
        ], 200);
    }
}
