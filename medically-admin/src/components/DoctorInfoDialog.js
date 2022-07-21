import { React, useState, useEffect, useRef } from "react";


const DoctorInfoDialog = (props) => {


function handleAdd(){
    props.addDoctor();
    props.closeDialog();
}
    if (props.isOpen) {
        return (
            <div className="request-info-body">
                <div className="request-info-container">
                    <input type="text" className="domain-input" placeholder="Channel Name" required />
                    <input type="text" className="domain-input" placeholder="Channel Token" required />
                    <button className="admin-btn" onClick={()=>{handleAdd()}}>Add</button>
                    <button onClick={props.closeDialog}>Cancel</button>
                </div>
            </div>
        );
    }
    return <div />

}

export default DoctorInfoDialog;