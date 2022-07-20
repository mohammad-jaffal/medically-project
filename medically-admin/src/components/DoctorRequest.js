

const DoctorRequest = ({ doctor_id, name, email, domain, balance }) => {



    return (
        <div className="data-container">
            <ul className="data-item">
                <li className="name-title">Name</li>
                <li className="email-title">Email</li>
                <button>reject</button>
                <button>accept</button>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <button>reject</button>
                <button>accept</button>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <button>reject</button>
                <button>accept</button>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <button>reject</button>
                <button>accept</button>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <button>reject</button>
                <button>accept</button>
            </ul>
        </div>
    );

}

export default DoctorRequest;