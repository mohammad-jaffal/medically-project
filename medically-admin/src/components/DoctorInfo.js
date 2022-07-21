

const DoctorInfo = ({ doctor_id, name, email, domain, balance }) => {



    return (
        <div className="info-container">
            <input type="text" className="domain-input" required />
            <input type="text" className="domain-input" required />
            <button className="admin-btn">Add</button>
        </div>
    );

}

export default DoctorInfo;