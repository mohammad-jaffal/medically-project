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

    // needs another look at the logic
    public function getFavoritesByUserID(Request $request){
        $favorites = Favorite::all()->where('user_id',$request->user_id);
        return response()->json([
            "success" => true,
            "favorites" => $favorites
        ], 200);
    }


}
