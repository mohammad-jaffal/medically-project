<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\DomainController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\CallController;
use App\Http\Controllers\ReviewController;
use App\Http\Controllers\BalanceController;
use App\Http\Controllers\UserController;

Route::group(['middleware' => 'api'], function($router) {
    Route::post('/register', [JWTController::class, 'register']);
    Route::post('/login', [JWTController::class, 'login']);
    Route::post('/logout', [JWTController::class, 'logout']);
    Route::post('/refresh', [JWTController::class, 'refresh']);
    Route::post('/profile', [JWTController::class, 'profile']);
});

Route::group(['prefix'=>'admin'], function(){
    Route::post('/add-doctor-details', [DoctorController::class, 'addDoctorDetails']);
    Route::post('/make-doctor', [DoctorController::class, 'makeDoctor']);
    Route::post('/add-domain', [DomainController::class, 'addDomain']);
    Route::get('/get-users', [UserController::class, 'getAllUsers']);

});


Route::group(['prefix'=>'user'], function(){
    Route::post('/add-favorite', [FavoriteController::class, 'addFavorite']);
    Route::post('/remove-favorite', [FavoriteController::class, 'removeFavorite']);
    Route::post('/get-favorites', [FavoriteController::class, 'getFavoritesByUserID']);

    Route::post('/add-call', [CallController::class, 'addCall']);
    Route::post('/get-user-calls', [CallController::class, 'getCallsByUserID']);
    Route::post('/get-doctor-calls', [CallController::class, 'getCallsByDoctorID']);

    Route::post('/add-review', [ReviewController::class, 'addReview']);

    Route::post('/set-doctor-status', [DoctorController::class, 'setStatus']);


    Route::post('/add-balance', [BalanceController::class, 'addBalance']);
    Route::post('/get-balance', [BalanceController::class, 'getBalance']);
    Route::post('/transfer-balance', [BalanceController::class, 'transferBalance']);
    

});


Route::get('/get-doctors', [DoctorController::class, 'getAllDoctors']);
Route::post('/get-doctor', [DoctorController::class, 'getDoctor']);
Route::get('/get-domains', [DomainController::class, 'getDomains']);
Route::post('/get-reviews', [ReviewController::class, 'getReviewsByDoctorID']);
