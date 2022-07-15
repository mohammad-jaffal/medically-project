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
    
    public function removeFavorite(Request $request){
        Favorite::where('user_id','=',$request->user_id)->where('doctor_id','=',$request->doctor_id)->delete();
       
        return response()->json([
            "success" => true,
        ], 200);
    }
    
    // needs another look at the logic
    public function getFavoritesByUserID(Request $request){
        $favorites = Favorite::where('user_id','=',$request->user_id)->get();
        return response()->json([
            "success" => true,
            "favorites" => $favorites
        ], 200);
    }


}
