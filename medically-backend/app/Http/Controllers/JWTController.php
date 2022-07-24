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
                'profile_picture' => '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAcHBwcIBwgJCQgMDAsMDBEQDg4QERoSFBIUEhonGB0YGB0YJyMqIiAiKiM+MSsrMT5IPDk8SFdOTldtaG2Pj8ABBwcHBwgHCAkJCAwMCwwMERAODhARGhIUEhQSGicYHRgYHRgnIyoiICIqIz4xKysxPkg8OTxIV05OV21obY+PwP/CABEIAZ8BnwMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABgcDBAUCAQj/2gAIAQEAAAAAvgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADDHOFy9dtdSQSH2AAAAAAObAIfgAbcyn26AAAAADxXsBxAAz2POgAAAABq1HHQABLLXygAAAAa1M8YAAElt/IAAAAHynoyAAAmlqAAAABBKyAAAFuSwAAAA1aJ1wAAB0b09gAAAK+rgAAAFqzMAAABRXMAAABI7lAAAA5VGAAAAe792AAAAQ6qAAAAFzyEAAAFe1yAAAAtWZgAAAraAAAAALOnQAAAK5r0AAABaM3AAABBqwAAAAW7KwAAARumwAAAF59UAAAGGgsQAAAN6+gAAAFRxMAAAE7s0AAABHKaAAAD1eXUAAAAKcjQAAAmlqAAAADl0lgAAAb137YAAAAROpfIAAMtxyAAAAACGVb4AAGa25OAAAAARqqdIAB0rZ7oAAAAAalcwzGAM84sLOAAAAAA0IbFuLjGXuyqY7YAAAAA5/QAY+drtro+gPmHOAAAA4lcRqW2htAAA0Kr4U6n2wAAAMdcQTyblhzb2AAwQWv8AAb1qSYAABq1BwAN6bS/qgDjQ2GaoPVkT4AAGpTfGADp97r72Zg0OPwNAALDsUAAeKZ4AAAAAAs+cgAFWwkAAAAAPdyyAACK1CAAAAAB0rvzgBho3ngAAAAAJ9ZQAV7XIAAAAABkvLpAGvROqAAAAAAJraYBAq0AAAAAADLe26AozlAAAAAAAsiwAOJSQAAAAAAHWvICua9AAAAAAAXn1QUpwgAAAAAAFnzkMf5/xgAAAAAAJhbAcejwAAAAAADs3ef/EABQBAQAAAAAAAAAAAAAAAAAAAAD/2gAIAQIQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//EABQBAQAAAAAAAAAAAAAAAAAAAAD/2gAIAQMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//EAEQQAAEDAQMHBwgIBAcAAAAAAAECAwQFAAYREiEiMUBBURMwUFJhcYEUICNCcoKxwRYyU2KRkqHRM1STwhAVVYCDsuH/2gAIAQEAAT8A/wBwLz7DCMt51DaeKjk2lXworBIQ4t8/cGaz9/HM4Yggdq12cvpWl6uQR3N2+lte/mR+RNhe6u/zCfyJs1fWsIwyksLHagizF/NQkQPFC/kbRb2UWQQC+WVcHBhZtxt1AW24laesk4jomo1aBTUZUl4A4ZkDOs+FqjfWa9iiG2GEdY512fkSJKyt91biuKjjzMWbLiLC4762j902p193kEInshaftEZleItBqMKc1ykZ9KxvG8d46FWtDaFLWoJSkElROAFqzfIkqZp3i8f7BZ1xx1anHFlayc6icSedjyX4rodYdU2salJNqLfFp4pYn4Nr1B0ZkHv4WBxwzjV0FLmxoUdb8hwIbTv+QtXLwyqqsoxLcYHRb49q9hoF53qcUsSCXIv6t91mHmn2kPNLC21gFKgegJcpiJHckPrCW0DObVqsyKtJy1kpaQSG29ydju/X3aU9kLJXFWdNHV+8LNOtvNocbUFoWAUqB1jbiQkFSiAADibXlrqqnJ5NskRWiQgdY9Y7LdOvGI8IUhfoHDoE+ovbr5VkstCnsq03AC8eCeHjs91KyZ0Pyd5WL7AA9pG47ZNmNQor8lz6rSSf2FpUl2XJdkOnFbiio7PS566dOYkox0Dpjig6xZtxDraHEEFCwCk8QdrvxUcEsQEHX6Rz5Dabl1Ev09cVZ045zewrasQM5NqxMM2py5BOZThCfZTmG03Wm+SVpjE6D2Lave2qtyjEpM14HOGiE96swtq2lKlIUlaTpJUCOwi0V9MiMw+nU42lX5htN9Xiikob+1eSPAZ9ruq+XqHD4oykH3TtN/V6FPR2uHa7kLKqU8jqvn9QNpv5/Hgewva7iKJhTRwdT8Npv6nTp6uxY2u4ycKdLPF74Dab9NYwobvVdUPzDa7mtZFFSeu6tXy2m9bHLUSRxbKVj3TtdEYMakwWiM4aBPerOdpfYS+w6yoaLiCg+9Z1pbLrjSxpIUUn3dppsUzJ8WOB/EcAPdvtmAA2q+EExasXkjQkgL97UdpuPBK5T8xY0Wk5CPaVtd6KaZ9KcKBi6wStHzG0JSpaglIJJIAFqLThTqaxHwGXhlOHitW2XnpJp1RUpAwYeJW32HenZ7nUkyphmuJ9EwdD7y9tq9MZqcFyOvAHWhXVVaQw9GfdYeSUuIJChstOgP1CW1GZGks5z1RvJtBhsworUZkaCB+PEnv26893xUWfKGAPKmx/UHCxBBIIIIJBGxtNOvOobbQVrWQEpA12u/RG6VGwVgqQ4AXF/wBo7B0BeW7ImhUuGkCR66Nzn/tlJUlRSoEKBIII2Fhl191DTLZW4o4JSBa713W6YgPO4LlKGc7kdg6Crt2o1TBdQQ1JwzL3K9q02DKgvlmS0UL3cD3Hfz9NpcypPcnHbx6yzmSnvNqNQYdKb0BlvEabpGfuHAdCTIMWcyWZLQWjt1juO61VuZKYKnIBL7fUOZYstC21lC0lChrSRgRzbLDz7gbZaU4s6kpGJtSrlOLKXKivJH2SdfibR4zEVpLLDSW2xqSkdDzqZBnpyZMdK+CvWHjabcZOdUKUR9x0fMWlXarUbErhqWnrI0xZaFtkhaCk9owtjj/iSBvs2066oJbbUsngMbRbrVqSQfJS0ni7o2g3GjoIVMkFz7iNEWiQYcJGRGYQ0nsHxPQb9VpzDyGXZrSXFEAJx+PDmXGmnczjaF+0kK+NnKJR3M66ewfdw+FvozQf5BuwuzQf9Pbs1RqQyQW4DA93H42QhDYwQhKBwSMn4cwpSUpKlEAAZzjZiQxIQFsOocTxQcra6reCn0wFLi8t3DM0jX48LVO9VTnEoQvkGuog5/FVjnJtRL1SYASxJxej7uui0ObFnMh6O6Fo7N3fw2OoVOFTWuVkuhPVT6yu4Wrd5ZlUJbGLMbc2PW9s2jS5MVwOR3ltL4pNqXfZQKW6i1iPtkfMWjSo8poOsOpcQd4OzuONtIU44sJQkEqUTmFq3fFxzKYpxKEai96x9mylKWSpRJJOck+ZEnSoLwdjPKbX2HMe8b7Um+sZ7JbqCORX9oBoHv4WadadQFtrC0HUpJxB5+RIYjNlx91LaB6yjhaq31SMWqc3iftl/IWfkPyXVOvuqccOtSj5kCpTae8HYzpQd43K7xaiXli1MBteDMnqbleydlmTY0Jhb8hwIQn9ewWrdfk1VwpztxwdBr5q4nmIdRnQV5UaQpvPnG494tAv1qTOjf8AK1+xtDrdKmgchLQVdQnJV+B5ubeCkQwQ5LSVdRGmbT78PrxRBjhsddec2lTJUtzlJD63Fdp+HnglJCkkgg5iDa7t6w6UQ6isBept4+t2K2ObNjwYzkiQvJbQPE9gtWazJqskuOaLaSeTb3JHORavVIgAYmOpA9XHKH4G0e+1WbwDjbLo7sk2av41m5anq9xdkX3pJ+s0+j3cbfTShdd/+lb6Z0LrP/0rLvxSk/UZfV4BNnr+pz8jTz76/wBrP3zrDmIbDTI7E4n9bSanUJeIkS3VjgVZvw5y7F5c6IM1zsZdP/QnYXnWmWluuLCUIBKlHcLV6tu1aTjnSwgnkkfM9p6DureAyUiDLX6ZI9Es+uOHfsF7a6ZLxgsL9C2fSEeusfIdCIWttaVoUUqSQUkHUbXerSarDBUQJDeAdT/cOevVWf8ALofIsqwkPghP3U71dDUqovU2a1IbxwBwWnrJ3i0d9qTHafZVlNuJBSecffajsuvunBCElSjapz3ajNdkueudEdVO4dD3Mq/JuGnOq0VkqZ9reOcvtVMA3Tm1a8FvfIdENuLacQ4gkLSQUngRak1FFSp7ElOGKhgscFDXzUqS3FjPPuHQbQVHwtLlOy5T0hw6biiT+3RNzKmWJq4azoP/AFexaeavvUeTYYgoOd05bnsp1dFNOLacQ4gkKQQUngRanTETYUeSnD0iASOB3jmMwtWpxn1OS+DolWSj2E5h0XcafiiTBUfqnlW+YvFNMOjynAcFrHJo719GUOb5FVoj+OCcsJX7Ksx5i/UvFUKGNwLivgOjaJL8spMN4nFRbAV3pzHz7ySvKq1MUDooUEJ7kdG3Gk5UKVHJ/hOhY7l+c64lppxxRzJSSezCzjinHFuK1rUVH3s/Rtyn+Tqym9zzJHiM486vulqjz1A5+RUPxzdHXfe5GtQF7uVwPiMPM//EABQRAQAAAAAAAAAAAAAAAAAAAJD/2gAIAQIBAT8AKT//xAAUEQEAAAAAAAAAAAAAAAAAAACQ/9oACAEDAQE/ACk//9k=',
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