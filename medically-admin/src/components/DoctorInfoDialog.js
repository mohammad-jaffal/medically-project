

const DoctorInfoDialog = ({ doctor_id, name, email, domain, balance, isOpen }) => {


    


    if (isOpen) {
        return (
            <div className="request-info-body">
                <div className="request-info-container">
                    <input type="text" className="domain-input" placeholder="Channel Name" required />
                    <input type="text" className="domain-input" placeholder="Channel Token" required />
                    <button className="admin-btn">Add</button>
                </div>
            </div>
        );
    }
    return <div />

}

export default DoctorInfoDialog;