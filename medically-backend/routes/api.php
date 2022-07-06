<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\DomainController;
use App\Http\Controllers\FavoriteController;

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
});


Route::group(['prefix'=>'user'], function(){
    Route::post('/add-favorite', [FavoriteController::class, 'addFavorite']);
    Route::post('/get-favorites', [FavoriteController::class, 'getFavoritesByUserID']);
});


Route::get('/get-doctors', [DoctorController::class, 'getAllDoctors']);
Route::get('/get-domains', [DomainController::class, 'getDomains']);