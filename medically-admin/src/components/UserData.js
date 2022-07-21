

const UserData = ({ user_id, name, email, balance }) => {



    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
            </tr>
        </table>
    );

}

export default UserData;