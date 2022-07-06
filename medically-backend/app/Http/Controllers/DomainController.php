<?php

namespace App\Http\Controllers;
use App\Models\Domain;

use Illuminate\Http\Request;

class DomainController extends Controller
{
    public function addDomain(Request $request){
        
        $domain = new Domain;
        $domain->domain_name = $request->domain_name;
        $domain->save();

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function getDomains(Request $request){
        $domains = Domain::all();
        return response()->json([
            "success" => true,
            "domains" => $domains
        ], 200);
    }

}
