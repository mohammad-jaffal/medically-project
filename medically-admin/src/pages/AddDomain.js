import Navbar from "../components/NavBar";
import { React, useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import * as myConstClass from '../consts/constants';


const AddDomain = () => {

    var token = localStorage.getItem('admin_token');
    const apiConst = myConstClass.api_const;

    var [domains, setDomains] = useState([]);
    const domainRef = useRef('');

    let navigate = useNavigate();


    // fetch all domains
    const fetchDomains = async () => {
        await fetch(`${apiConst}/get-domains`, {
            method: "GET",
        }).then(async res => {
            if (res.ok) {
                const data = await res.json();
                setDomains(data['domains']);
            }
        });
    }

    // Add domain
    const addDomainFunction = async () => {
        var domain_name = domainRef.current.value;
        if (domain_name == "") {
            alert("Enter name !")
        } else {
            const params = new FormData();
            params.append('domain_name', domain_name);
            await fetch(`${apiConst}/admin/add-domain`, {
                method: "POST",
                body: params,
                headers: {
                    "Authorization": 'Bearer ' + token,
                    "Accept": 'application/json',
                },
            }).then(async res => {
                if (res.ok) {

                    const data = await res.json();
                    fetchDomains();
                    domainRef.current.value = "";
                } else {
                    // redirect to login if error
                    localStorage.setItem('admin_token', "none");
                    navigate("/", { replace: true });
                }
            });
        }
    }



    // use effect :)
    useEffect(() => {
        fetchDomains();
    }, [])

    return (
        <div className="global-container">
            <Navbar />
            <div className="add-domain-body">
                <p className="block-title">Add Domain:</p>
                <div className="domain-input-container">
                    <input ref={domainRef} type="text" className="domain-input" required />
                    <button className="admin-btn" onClick={() => { addDomainFunction() }}>Add</button>
                </div>
                <p className="block-title">Available Domains:</p>
                <ul className="domains-container">
                    {domains.map((domain, index) => {
                        return (
                            <li key={index} className="domain-card"><span>{domain.domain_name}</span></li>
                        )
                    })}
                </ul>
            </div>
        </div>
    );
}

export default AddDomain;