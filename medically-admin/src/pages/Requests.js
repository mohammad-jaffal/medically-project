import { React, useState, useEffect, useRef } from "react";
import DoctorInfoDialog from "../components/DoctorInfoDialog";
import DoctorRequest from "../components/DoctorRequest";
import Navbar from "../components/NavBar";

const Requests = () => {

    var [isDialogOpen, setIsDialogOpen] = useState(false);
    function acceptFuntion(x){
        setIsDialogOpen(true);
        console.log(x);
    }
    function rejectFuntion(x){
        console.log(x);
    }
    function closeFunction(){
        setIsDialogOpen(false);
    }

    function addFunction(){
        console.log('adding');
    }
    return (
        <div className="global-container">
            <Navbar />
            <div className="requests-body">
                <p className="block-title">Requests:</p>
                {/* <input type="text" className="search-input" placeholder="Name / Email" /> */}
                <DoctorRequest
                    name={'first name'}
                    email={'firstemail@gmail.com'}
                    accept={() => { acceptFuntion('accept an id') }}
                    decline={() => { rejectFuntion('reject an id') }}
                />
                <DoctorInfoDialog isOpen={isDialogOpen} closeDialog={closeFunction} addDoctor={addFunction}/>
            </div>
        </div>
    );
}

export default Requests;