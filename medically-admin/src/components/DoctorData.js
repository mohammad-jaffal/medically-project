

const DoctorData = ({ doctor_id, name, email, domain, balance }) => {



    return (
        <div className="data-container">
            <ul className="data-item">
                <li className="name-title">Name</li>
                <li className="email-title">Email</li>
                <li className="balance-title">Balance</li>
                <li className="domain-title">Domain</li>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
                <li className="domain-item">{domain}</li>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
                <li className="domain-item">{domain}</li>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
                <li className="domain-item">{domain}</li>
            </ul>
            <ul className="data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
                <li className="domain-item">{domain}</li>
            </ul>
        </div>
    );

}

export default DoctorData;