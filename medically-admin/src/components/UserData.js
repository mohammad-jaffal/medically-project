

const UserData = ({ user_id, name, email, balance }) => {



    return (
        <div className="user-data">
            <ul className="user-data-item">
                <li className="name-title">Name</li>
                <li className="email-title">Email</li>
                <li className="balance-title">Balance</li>
            </ul>
            <ul className="user-data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
            </ul>
            <ul className="user-data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
            </ul>
            <ul className="user-data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
            </ul>
            <ul className="user-data-item">
                <li className="name-item">{name}</li>
                <li className="email-item">{email}</li>
                <li className="balance-item">{balance}</li>
            </ul>
        </div>
    );

}

export default UserData;