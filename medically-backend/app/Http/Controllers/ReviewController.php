<?php

namespace App\Http\Controllers;
use App\Models\Review;

use Illuminate\Http\Request;

class ReviewController extends Controller
{
    public function addReview(Request $request){
        
        $review = new Review;
        $review->user_id = $request->user_id;
        $review->doctor_id = $request->doctor_id;
        $review->review_text = $request->review_text;
        $review->rating = $request->rating;
        $review->save();

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function getReviewsByDoctorID(Request $request){
        $reviews = Review::all()->where('doctor_id',$request->doctor_id);
        return response()->json([
            "success" => true,
            "reviews" => $reviews
        ], 200);
    }
}
