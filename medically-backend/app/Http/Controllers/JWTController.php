<?php

namespace App\Http\Controllers;

use Auth;
use Validator;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class JWTController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    /**
     * Register user.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|min:2|max:100',
            'email' => 'required|string|email|max:100|unique:users',
            'password' => 'required|string|confirmed|min:6',
        ]);

        if($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        $checked_type = $request->type;
        if($checked_type != 1 and $checked_type != 3) {
            $checked_type = 1;
        }
            
    
        $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'type' => $checked_type,
                'profile_picture' => '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',
                'balance' => 0,
            ]);

        return response()->json([
            'message' => 'User successfully registered',
            'user' => $user
        ], 201);
    }

    /**
     * login user
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        if (!$token = auth()->attempt($validator->validated())) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Logout user
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'User successfully logged out.']);
    }

    /**
     * Refresh token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get user profile.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function profile()
    {
        return response()->json(auth()->user());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL()
        ]);
    }
}