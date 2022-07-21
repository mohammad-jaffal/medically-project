

const UserData = ({ users }) => {

    console.log(users);

    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
            </tr>
            {users.map((user, index) => {
                return (
                    <tr key={index}>
                        <td>{user.name}</td>
                        <td>{user.email}</td>
                        <td>{user.balance}</td>
                    </tr>
                )
            })}
            
        </table>
    );

}

export default UserData;